module TestingSupport
  module CapybaraHelper

    def with_rack_test_driver
      current_driver = Capybara.current_driver
      Capybara.current_driver = :rack_test
      yield
      Capybara.current_driver = current_driver
    end

    def with_rack_test_driver_api_session
      with_rack_test_driver do
        if @api_token_data.present?
          page.driver.header 'Auth-Token', @api_token_data['token']
          page.driver.header 'Auth-Secret', @api_token_data['secret']
        end
        yield
        if @api_token_data.present?
          page.driver.header 'Auth-Token', nil
          page.driver.header 'Auth-Secret', nil
        end
      end
    end

    def find_if_exists(id)
      begin
        find(id)
      rescue Capybara::ElementNotFound
      end
    end
  end
end
