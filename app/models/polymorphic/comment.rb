# Fat Free CRM
# Copyright (C) 2008-2011 by Michael Dvorkin
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#------------------------------------------------------------------------------

# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  private          :boolean
#  title            :string(255)     default("")
#  comment          :text
#  created_at       :datetime
#  updated_at       :datetime
#  state            :string(16)      default("Expanded"), not null
#

class Comment < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :commentable, :polymorphic => true

  scope :created_by, lambda { |user| where(:user_id => user.id) }

  validates_presence_of :user, :commentable, :comment
  has_paper_trail :meta => { :related => :commentable }

  def expanded?;  self.state == "Expanded";  end
  def collapsed?; self.state == "Collapsed"; end
end
