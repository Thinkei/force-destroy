class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy

  before_destroy :allow_destroy?

  private

  def allow_destroy?
    errors.add(:base, 'Do not destroy profile')
    throw(:abort)
  end
end
