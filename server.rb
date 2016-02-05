require 'sinatra'
require 'pony'

get '/' do
  erb :index
end

post '/contact' do
    settings = YAML::load(File.open(File.expand_path("mail_form.yml")))

    Pony.mail to:      settings['recipient'],
              from:    settings['no_reply'],
              subject: settings['subject'],
              body:    <<-EOT
      Parent Information:
      Name: #{params[:name]}
      Address: #{params[:address]}
      City: #{params[:city]}
      State: #{params[:state]}
      Zip: #{params[:zipcode]}
      Phone: #{params[:phone]}
      Email: #{params[:email]}
      Children:
      Name: #{params[:child1]}
      Date of Birth: #{params[:child1_dob]}
      Program of Interest: #{params[:program]}
      Name: #{params[:child2]}
      Date of Birth: #{params[:child2_dob]}
      Program of Interest: #{params[:program2]}
      What elementary school does your child attend?: #{params[:school]}
      How did you hear about us?: #{params[:referral]}
      Additional comments and/or questions: #{params[:comments]}
    EOT

    redirect to(settings['site'])
  end

post '/contact' do
   Pony.mail({
    :from => params[:name],
    :to => '',
    :subject => params[:name] + "has contacted you via the Website",
    :body => params[:comment],
    :via => :smtp,
    :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'myemailaddress',
    :password             => 'mypassword',
    :authentication       => :plain,
    :domain               => "localhost.localdomain"
    }
  })
  redirect '/'
end


get '/success' do
  @notification = "Thanks for your email. I'll be in touch soon."
  erb :index, :layout => :layout
end
