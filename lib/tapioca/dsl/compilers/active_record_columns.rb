# typed: strict
# frozen_string_literal: true

return unless defined?(ActiveRecord::Base)

require "tapioca/dsl/helpers/active_record_column_type_helper"
require "tapioca/dsl/helpers/active_record_constants_helper"

module Tapioca
  module Dsl
    module Compilers
      # `Tapioca::Dsl::Compilers::ActiveRecordColumns` refines RBI files for subclasses of
      # [`ActiveRecord::Base`](https://api.rubyonrails.org/classes/ActiveRecord/Base.html).
      # This compiler is only responsible for defining the attribute methods that would be
      # created for columns and virtual attributes that are defined in the Active Record
      # model.
      #
      # For example, with the following model class:
      # ~~~rb
      # class Post < ActiveRecord::Base
      # end
      # ~~~
      #
      # and the following database schema:
      #
      # ~~~rb
      # # db/schema.rb
      # create_table :posts do |t|
      #   t.string :title, null: false
      #   t.string :body
      #   t.boolean :published
      #   t.timestamps
      # end
      # ~~~
      #
      # this compiler will produce the following methods in the RBI file
      # `post.rbi`:
      #
      # ~~~rbi
      # # post.rbi
      # # typed: true
      # class Post
      #   include GeneratedAttributeMethods
      #
      #   module GeneratedAttributeMethods
      #     sig { returns(T.nilable(::String)) }
      #     def body; end
      #
      #     sig { params(value: T.nilable(::String)).returns(T.nilable(::String)) }
      #     def body=; end
      #
      #     sig { returns(T::Boolean) }
      #     def body?; end
      #
      #     sig { returns(T.nilable(::ActiveSupport::TimeWithZone)) }
      #     def created_at; end
      #
      #     sig { params(value: ::ActiveSupport::TimeWithZone).returns(::ActiveSupport::TimeWithZone) }
      #     def created_at=; end
      #
      #     sig { returns(T::Boolean) }
      #     def created_at?; end
      #
      #     sig { returns(T.nilable(T::Boolean)) }
      #     def published; end
      #
      #     sig { params(value: T::Boolean).returns(T::Boolean) }
      #     def published=; end
      #
      #     sig { returns(T::Boolean) }
      #     def published?; end
      #
      #     sig { returns(::String) }
      #     def title; end
      #
      #     sig { params(value: ::String).returns(::String) }
      #     def title=(value); end
      #
      #     sig { returns(T::Boolean) }
      #     def title?; end
      #
      #     sig { returns(T.nilable(::ActiveSupport::TimeWithZone)) }
      #     def updated_at; end
      #
      #     sig { params(value: ::ActiveSupport::TimeWithZone).returns(::ActiveSupport::TimeWithZone) }
      #     def updated_at=; end
      #
      #     sig { returns(T::Boolean) }
      #     def updated_at?; end
      #
      #     ## Also the methods added by https://api.rubyonrails.org/classes/ActiveRecord/AttributeMethods/Dirty.html
      #     ## Also the methods added by https://api.rubyonrails.org/classes/ActiveModel/Dirty.html
      #     ## Also the methods added by https://api.rubyonrails.org/classes/ActiveRecord/AttributeMethods/BeforeTypeCast.html
      #   end
      # end
      # ~~~
      class ActiveRecordColumns < Compiler
        extend T::Sig
        include Helpers::ActiveRecordConstantsHelper

        ConstantType = type_member { { fixed: T.class_of(ActiveRecord::Base) } }

        sig { override.void }
        def decorate
          return unless constant.table_exists?

          # We need to call this to ensure that some attribute aliases are defined, e.g.
          # `id_value` as an alias for `id`.
          # I think this is a regression on Rails 7.1, but we are where we are.
          constant.define_attribute_methods

          root.create_path(constant) do |model|
            model.create_module(AttributeMethodsModuleName) do |mod|
              (constant.attribute_names + ["id"]).uniq.each do |attribute_name|
                add_methods_for_attribute(mod, attribute_name)
              end

              constant.attribute_aliases.each do |attribute_name, column_name|
                attribute_name = attribute_name.to_s
                column_name = column_name.to_s
                patterns = if constant.respond_to?(:attribute_method_patterns)
                  # https://github.com/rails/rails/pull/44367
                  constant.attribute_method_patterns
                else
                  T.unsafe(constant).attribute_method_matchers
                end
                new_method_names = patterns.map { |m| m.method_name(attribute_name) }
                old_method_names = patterns.map { |m| m.method_name(column_name) }
                methods_to_add = new_method_names - old_method_names

                add_methods_for_attribute(mod, attribute_name, column_name, methods_to_add)
              end
            end

            model.create_include(AttributeMethodsModuleName)
          end
        end

        class << self
          extend T::Sig

          sig { override.returns(T::Enumerable[Module]) }
          def gather_constants
            descendants_of(::ActiveRecord::Base).reject(&:abstract_class?)
          end
        end

        private

        sig { returns(Helpers::ActiveRecordColumnTypeHelper::ColumnTypeOption) }
        def column_type_option
          @column_type_option ||= T.let(
            Helpers::ActiveRecordColumnTypeHelper::ColumnTypeOption.from_serialized(
              options.fetch(
                "types",
                Helpers::ActiveRecordColumnTypeHelper::ColumnTypeOption::Persisted.serialize,
              ),
            ),
            T.nilable(Helpers::ActiveRecordColumnTypeHelper::ColumnTypeOption),
          )
        end

        sig do
          params(
            klass: RBI::Scope,
            name: String,
            methods_to_add: T.nilable(T::Array[String]),
            return_type: String,
            parameters: T::Array[RBI::TypedParam],
          ).void
        end
        def add_method(klass, name, methods_to_add, return_type: "void", parameters: [])
          klass.create_method(
            name,
            parameters: parameters,
            return_type: return_type,
          ) if methods_to_add.nil? || methods_to_add.include?(name)
        end

        sig do
          params(
            klass: RBI::Scope,
            attribute_name: String,
            column_name: String,
            methods_to_add: T.nilable(T::Array[String]),
          ).void
        end
        def add_methods_for_attribute(klass, attribute_name, column_name = attribute_name, methods_to_add = nil)
          getter_type, setter_type = Helpers::ActiveRecordColumnTypeHelper
            .new(constant, column_type_option: column_type_option)
            .type_for(attribute_name, column_name)

          # Added by ActiveRecord::AttributeMethods::Read
          #
          add_method(
            klass,
            attribute_name.to_s,
            methods_to_add,
            return_type: getter_type,
          )

          # Added by ActiveRecord::AttributeMethods::Write
          #
          add_method(
            klass,
            "#{attribute_name}=",
            methods_to_add,
            parameters: [create_param("value", type: setter_type)],
            return_type: setter_type,
          )

          # Added by ActiveRecord::AttributeMethods::Query
          #
          add_method(
            klass,
            "#{attribute_name}?",
            methods_to_add,
            return_type: "T::Boolean",
          )

          # Added by ActiveRecord::AttributeMethods::Dirty
          #
          add_method(
            klass,
            "#{attribute_name}_before_last_save",
            methods_to_add,
            return_type: as_nilable_type(getter_type),
          )
          add_method(
            klass,
            "#{attribute_name}_change_to_be_saved",
            methods_to_add,
            return_type: "T.nilable([#{getter_type}, #{getter_type}])",
          )
          add_method(
            klass,
            "#{attribute_name}_in_database",
            methods_to_add,
            return_type: as_nilable_type(getter_type),
          )
          add_method(
            klass,
            "saved_change_to_#{attribute_name}",
            methods_to_add,
            return_type: "T.nilable([#{getter_type}, #{getter_type}])",
          )
          add_method(
            klass,
            "saved_change_to_#{attribute_name}?",
            methods_to_add,
            return_type: "T::Boolean",
          )
          add_method(
            klass,
            "will_save_change_to_#{attribute_name}?",
            methods_to_add,
            return_type: "T::Boolean",
          )

          # Added by ActiveModel::Dirty
          #
          add_method(
            klass,
            "#{attribute_name}_change",
            methods_to_add,
            return_type: "T.nilable([#{getter_type}, #{getter_type}])",
          )
          add_method(
            klass,
            "#{attribute_name}_changed?",
            methods_to_add,
            return_type: "T::Boolean",
            parameters: [
              create_kw_opt_param("from", type: setter_type, default: "T.unsafe(nil)"),
              create_kw_opt_param("to", type: setter_type, default: "T.unsafe(nil)"),
            ],
          )
          add_method(
            klass,
            "#{attribute_name}_will_change!",
            methods_to_add,
          )
          add_method(
            klass,
            "#{attribute_name}_was",
            methods_to_add,
            return_type: as_nilable_type(getter_type),
          )
          add_method(
            klass,
            "#{attribute_name}_previous_change",
            methods_to_add,
            return_type: "T.nilable([#{getter_type}, #{getter_type}])",
          )
          add_method(
            klass,
            "#{attribute_name}_previously_changed?",
            methods_to_add,
            return_type: "T::Boolean",
            parameters: [
              create_kw_opt_param("from", type: setter_type, default: "T.unsafe(nil)"),
              create_kw_opt_param("to", type: setter_type, default: "T.unsafe(nil)"),
            ],
          )
          add_method(
            klass,
            "#{attribute_name}_previously_was",
            methods_to_add,
            return_type: as_nilable_type(getter_type),
          )
          add_method(
            klass,
            "restore_#{attribute_name}!",
            methods_to_add,
          )

          # Added by ActiveRecord::AttributeMethods::BeforeTypeCast
          #
          add_method(
            klass,
            "#{attribute_name}_before_type_cast",
            methods_to_add,
            return_type: "T.untyped",
          )
          add_method(
            klass,
            "#{attribute_name}_came_from_user?",
            methods_to_add,
            return_type: "T::Boolean",
          )
        end
      end
    end
  end
end
