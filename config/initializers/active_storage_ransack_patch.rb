# config/initializers/active_storage_ransack_patch.rb

Rails.application.config.to_prepare do
  if defined?(ActiveStorage::Attachment)
    module ActiveStorageRansackPatch
      extend ActiveSupport::Concern

      included do
        def self.ransackable_attributes(auth_object = nil)
          %w[blob_id created_at id name record_id record_type]
        end

        def self.ransackable_associations(auth_object = nil)
          %w[blob record]
        end
      end
    end

    ActiveStorage::Attachment.include(ActiveStorageRansackPatch)
  else
    Rails.logger.warn("ActiveStorage::Attachment is not defined. The ransack patch could not be applied.")
  end
end
