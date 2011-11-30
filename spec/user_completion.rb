class UserCompletion < Completely::Base
  step "Set up your profile" do
    path "/profile/new"
  end

  step "Set up your dynamic profile" do
    path        "/profile/#{object.id}"
    completed   object.dynamic_completed?
  end

  list_elt        'ul.user-completion'
  item_elt        'li.completion-item'
  completed_class 'done'
end

class User
  def id
    'some-id'
  end

  def dynamic_completed?
    true
  end
end
