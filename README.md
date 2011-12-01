= Completely

Completely is a progress-tracker, for use when you want to have a 'checklist' of items that a user should complete. Use it like this:

```ruby
module UserHelper
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
end
```

And then in your view:

```ruby
  <% progress = UserHelper::UserCompletion.new(current_user) %>
  <%= progress.progress_bar.html_safe %>
  <%= progress.to_html.html_safe %>
```

You are expected to style it using CSS.


