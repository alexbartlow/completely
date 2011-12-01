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

```erb
  <% progress = UserHelper::UserCompletion.new(current_user) %>
  <%= progress.progress_bar.html_safe %>
  <%= progress.to_html.html_safe %>
```

Which results in the following output:

```html
<div class="progress_bar">
  <div class="progress" style="width:66%">66%</div>
</div>
<ul class="user-completion">
  <li class="completion-item">
    <a href="/profile/new">Set up your profile</a>
  </li>
  <li class="completion-item done">
    <a href="/profile/some-id">Set up your dynamic profile</a>
  </li>
</ul>
```

You are expected to style it using CSS.

