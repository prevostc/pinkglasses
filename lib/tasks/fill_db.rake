namespace :fill_db do
  desc "Fill database with a bunch of pictures"
  task :init => :environment do
    Dir.foreach("public/images/glasses/") do |f|
      if f != "." && f != ".." then
        # do whatever you want with f, which is a filename within the
        # given directory (not fully-qualified)
        i = Item.new
        i.score = 1000
        i.image_path = "/images/glasses/#{f}" 
        
        if !Item.find_by_image_path(i.image_path) then
          puts "Trying to save new item"
          i.save!
          puts "Success !"
        else
          puts "Existing #{i.image_path}"
        end
      end
    end
  end
end