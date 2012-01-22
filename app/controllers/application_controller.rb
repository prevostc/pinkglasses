class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
  
  def uri_escape uri
    URI.escape(uri, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"));
  end

  def twitter_link(link, text, via = "mash")
    "http://twitter.com/share?" +
      "url=" + uri_escape(link) + "&amp;" +
      "via=" + uri_escape(via) + "&amp;" +
      "text=" + uri_escape(text);
  end

  def facebook_link(link, title = "mash")
    "http://www.facebook.com/sharer.php?" +
      "u=" + uri_escape(link) + "&amp;" +
      "t="+ uri_escape(title);
  end

end
