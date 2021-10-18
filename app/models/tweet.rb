class Tweet < ApplicationRecord
  validates :body, presence: true

  # after_create_commit { broadcast_prepend_to "tweets" }
  # after_destroy_commit { broadcast_remove_to "tweets" }
  broadcasts_to ->(tweet) { :tweets }, inserts_by: :prepend, target: "tweets"
end
