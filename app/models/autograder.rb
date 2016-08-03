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

  def save_file(upload)
    filename = course_user_datum.user.email + "_" +
               version.to_s + "_" +
               assessment.handin_filename
    directory = assessment.handin_directory
    path = File.join(Rails.root, "courses",
                     course_user_datum.course.name,
                     assessment.name, filename)

    if upload["file"]
      # Sanity!
      upload["file"].rewind
      File.open(path, "wb") { |f| f.write(upload["file"].read) }
    elsif upload["local_submit_file"]
      # local_submit_file is a path string to the temporary handin
      # directory we create for local submissions
      File.open(path, "wb") { |f| f.write(IO.read(upload["local_submit_file"])) }
    elsif upload["tar"]
      src = upload["tar"]
      `mv #{src} #{path}`
    end

    self.filename = filename
    if upload["file"]
      self.mime_type = upload["file"].content_type
      self.mime_type = "text/plain" unless mime_type
    elsif upload["local_submit_file"]
      self.mime_type = "text/plain"
    elsif upload["tar"]
      self.mime_type = "application/x-tgz"
    end
    if assessment.has_autograder?
        self.grader = "Autolab"
    else
        self.grader = "Not assigned"
    end
    self.save!
  end


  SERIALIZABLE = Set.new %w(autograde_image autograde_timeout release_score)
  def serialize
    Utilities.serializable attributes, SERIALIZABLE
  end
end
