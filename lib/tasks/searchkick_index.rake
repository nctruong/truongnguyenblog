namespace :searchkick do
  desc 'Reindex all models on all posts'
  task reindex_posts: :environment do
    Post.reindex
    puts 'done'
  end
end