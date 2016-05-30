module TestingSupport
  module SessionHelper
    # API Sessions
    def api_login_with_user(app_user, raw_password)
      api_login(app_user.mail, raw_password)
    end

    def api_login(mail, raw_password)
      url = api_users_login_url(format: :json)
      with_rack_test_driver do
        data = api_user_params(mail, raw_password)
        page.driver.submit :post, url, data
      end
      data = JSON.parse(page.body)
      token_data = @api_token_data = data['token']
      if token_data.present?
        @api_user = Api::AppUser.find(token_data['api_user']['id'])
      end
    end

    def create_api_session
      raw_password = '123456'
      app_user = create(:app_user, raw_password: raw_password, mock_processor_context: self)
      api_login(app_user.mail, raw_password)
    end

    def api_user_params(mail, raw_password)
      {
        app_user: {
          mail: mail,
          password: raw_password
        }
      }
    end
  end
end
