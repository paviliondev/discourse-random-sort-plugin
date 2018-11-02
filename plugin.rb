# name: discourse-random-sort
# about: Adds a nav item to show random topics.
# version: 0.1
# author: Procourse
# url: https://github.com/discourse/discourse-random-sort-plugin

Discourse.top_menu_items.push(:random)
Discourse.anonymous_top_menu_items.push(:random)
Discourse.filters.push(:random)
Discourse.anonymous_filters.push(:random)

after_initialize do
  require_dependency 'topic_query'
  class ::TopicQuery
    def list_random
      create_list(:random, unordered: true) do |topics|
        topics = topics.order("RANDOM()")
      end
    end
  end

  require_dependency 'list_controller'
  class ::ListController
    def random_feed
      list = generate_list_for("random", target_user, list_opts)
      respond_with_list(list)
    end
  end

  Discourse::Application.routes.append do
    get "random" => "list#random_feed"
  end
end
