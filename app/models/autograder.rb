##
# This model has nothing to do with actually autograding assessments, and instead deals
# with autograding properties for an assessment
#
class Autograder < ActiveRecord::Base
  belongs_to :assessment

  trim_field :autograde_image

  # extremely short timeout values cause the backend to throw system errors
  validates :autograde_timeout, numericality: { greater_than: 10, less_than: 900 }
  validates :autograde_image, :autograde_timeout, presence: true
  validates :autograde_image, length: { maximum: 64 }

  after_save -> { assessment.dump_yaml }

  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the owner's name is present.

  #has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }

  SERIALIZABLE = Set.new %w(autograde_image autograde_timeout release_score)
  def serialize
    Utilities.serializable attributes, SERIALIZABLE
  end
end

