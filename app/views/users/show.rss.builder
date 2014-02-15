xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Microposts"
    xml.description "User #{@user.name}"
    xml.link user_url(@user, :rss)
    
    for post in @user.microposts
      xml.item do
        xml.author post.user.name
        xml.title post.content
        xml.pubDate post.created_at.to_s(:rfc822)
      end
    end
  end
end