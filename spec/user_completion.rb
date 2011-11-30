class UserCompletion < Completely::Base
  step "Set up your profile", :score => 10 do
   path        "/profile/new"
   completed   false
  end

  step "Set up your dynamic profile", :score => 20 do
    path        "/profile/#{object.id}"
    completed   object.dynamic_completed?
  end

  list_elt        'ul.user-completion'
  item_elt        'li.completion-item'
  completed_class 'done'
end

