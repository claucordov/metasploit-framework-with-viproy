require 'rex/proto/http/response'

describe Rex::Proto::Http::Response do

  def get_cookies_test_no_cookies
    <<-HEREDOC.gsub(/^ {6}/, '')
      HTTP/1.1 200 OK
      Date: Fri, 26 Apr 2013 12:43:12 GMT
      Server: Apache/2.2.22 (Ubuntu)
      X-Powered-By: PHP/5.4.6-1ubuntu1.2
      Expires: Thu, 19 Nov 1981 08:52:00 GMT
      Cache-Control: private, max-age=10800, pre-check=10800
      Last-Modified: Fri, 26 Apr 2013 12:01:52 GMT
      Vary: Accept-Encoding
      Content-Length: 63951
      Keep-Alive: timeout=5, max=100
      Connection: Keep-Alive
      Content-Type: text/html

      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">'
    HEREDOC
  end

  def get_cookies_test_five_cookies
    <<-HEREDOC.gsub(/^ {6}/, '')
      HTTP/1.1 200 OK
      Date: Fri, 26 Apr 2013 08:44:54 GMT
      Server: Apache/2.2.22 (Ubuntu)
      X-Powered-By: PHP/5.4.6-1ubuntu1.2
      Set-Cookie: phpMyAdmin=gpjif0gtpqbvfion91ddtrq8p8vgjtue; path=/phpmyadmin/; HttpOnly
      Expires: Thu, 19 Nov 1981 08:52:00 GMT
      Cache-Control: private, max-age=10800, pre-check=10800
      Last-Modified: Sun, 12 Aug 2012 13:38:18 GMT
      Set-Cookie: pma_lang=en; expires=Sun, 26-May-2013 08:44:54 GMT; path=/phpmyadmin/; httponly
      Set-Cookie: pma_collation_connection=utf8_general_ci; expires=Sun, 26-May-2013 08:44:54 GMT; path=/phpmyadmin/; httponly
      Set-Cookie: pma_mcrypt_iv=mF1NmTE64IY%3D; expires=Sun, 26-May-2013 08:44:54 GMT; path=/phpmyadmin/; httponly
      Set-Cookie: phpMyAdmin=fmilioji5cn4m8bo5vjrrr6q9cada954; path=/phpmyadmin/; HttpOnly
      Vary: Accept-Encoding
      Content-Length: 7356
      Keep-Alive: timeout=5, max=100
      Connection: Keep-Alive
      Content-Type: text/html; charset=utf-8

      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    HEREDOC
  end

  def get_cookies_test_five_ordered_cookies
    <<-HEREDOC.gsub(/^ {6}/, '')
      HTTP/1.1 200 OK
      Date: Fri, 26 Apr 2013 08:44:54 GMT
      Server: Apache/2.2.22 (Ubuntu)
      X-Powered-By: PHP/5.4.6-1ubuntu1.2
      Expires: Thu, 19 Nov 1981 08:52:00 GMT
      Cache-Control: private, max-age=10800, pre-check=10800
      Last-Modified: Sun, 12 Aug 2012 13:38:18 GMT
      Set-Cookie: pma_lang=en; expires=Sun, 26-May-2013 08:44:54 GMT; path=/phpmyadmin/; httponly
      Set-Cookie: pma_collation_connection=utf8_general_ci; expires=Sun, 26-May-2013 08:44:54 GMT; path=/phpmyadmin/; httponly
      Set-Cookie: pma_mcrypt_iv=mF1NmTE64IY%3D; expires=Sun, 26-May-2013 08:44:54 GMT; path=/phpmyadmin/; httponly
      Set-Cookie: phpMyAdmin=fmilioji5cn4m8bo5vjrrr6q9cada954; path=/phpmyadmin/; HttpOnly
      Set-Cookie: superC00kie!=stupidcookie; Path=/parp/; domain=.foo.com; HttpOnly; Expires=Wed, 13-Jan-2012 22:23:01 GMT; Secure
      Vary: Accept-Encoding
      Content-Length: 7356
      Keep-Alive: timeout=5, max=100
      Connection: Keep-Alive
      Content-Type: text/html; charset=utf-8

      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    HEREDOC
  end

  def get_cookies_test_with_empty_cookie
    <<-HEREDOC.gsub(/^ {6}/, '')
      HTTP/1.1 200 OK
      Date: Fri, 26 Apr 2013 08:44:54 GMT
      Server: Apache/2.2.22 (Ubuntu)
      X-Powered-By: PHP/5.4.6-1ubuntu1.2
      Set-Cookie: phpMyAdmin=gpjif0gtpqbvfion91ddtrq8p8vgjtue; path=/phpmyadmin/; HttpOnly
      Expires: Thu, 19 Nov 1981 08:52:00 GMT
      Cache-Control: private, max-age=10800, pre-check=10800
      Last-Modified: Sun, 12 Aug 2012 13:38:18 GMT
      Set-Cookie: pma_lang=en; expires=Sun, 26-May-2013 08:44:54 GMT; path=/phpmyadmin/; httponly
      Set-Cookie: pma_collation_connection=utf8_general_ci; expires=Sun, 26-May-2013 08:44:54 GMT; path=/phpmyadmin/; httponly
      Set-Cookie: pma_mcrypt_iv=mF1NmTE64IY%3D; expires=Sun, 26-May-2013 08:44:54 GMT; path=/phpmyadmin/; httponly
      Set-Cookie: phpMyAdmin=; path=/phpmyadmin/; HttpOnly
      Vary: Accept-Encoding
      Content-Length: 7356
      Keep-Alive: timeout=5, max=100
      Connection: Keep-Alive
      Content-Type: text/html; charset=utf-8

      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    HEREDOC
  end

  def get_cookies_test_one_set_cookie_header
    <<-HEREDOC.gsub(/^ {6}/, '')
      HTTP/1.1 200 OK
      Date: Wed, 25 Sep 2013 20:29:23 GMT
      Server: Apache/2.2.22 (Ubuntu)
      X-Powered-By: PHP/5.4.9-4ubuntu2.2
      Expires: Wed, 11 Jan 1984 05:00:00 GMT
      Last-Modified: Wed, 25 Sep 2013 20:29:23 GMT
      Cache-Control: no-cache, must-revalidate, max-age=0
      Pragma: no-cache
      Set-Cookie: wordpressuser_a97c5267613d6de70e821ff82dd1ab94=admin; path=/wordpress-2.0/, wordpresspass_a97c5267613d6de70e821ff82dd1ab94=c3284d0f94606de1fd2af172aba15bf3; path=/wordpress-2.0/
      Vary: Accept-Encoding
      Content-Length: 0
      Content-Type: text/html; charset=UTF-8

      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    HEREDOC
  end

  def get_cookies_comma_separated
    <<-HEREDOC.gsub(/^ {6}/, '')
      HTTP/1.1 200 OK
      Expires: Thu, 26 Oct 1978 00:00:00 GMT
      Content-Length: 8556
      Server: CherryPy/3.1.2
      Date: Sun, 06 Jul 2014 20:09:28 GMT
      Cache-Control: no-store, max-age=0, no-cache, must-revalidate
      Content-Type: text/html;charset=utf-8
      Set-Cookie: cval=880350187, session_id_8000=83466b1a1a7a27ce13d35f78155d40ca3a1e7a28; expires=Mon, 07 Jul 2014 20:09:28 GMT; httponly; Path=/, uid=348637C4-9B10-485A-BFA9-5E892432FCFD; expires=Fri, 05-Jul-2019 20:09:28 GMT

      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <!--[if lt IE 7]> <html xmlns="http://www.w3.org/1999/xhtml" xmlns:s="http://www.splunk.com/xhtml-extensions/1.0" xml:lang="en" lang="en" class="no-js lt-ie9 lt-ie8 lt-
    HEREDOC
  end

  def cookie_sanity_check(meth)
    resp = described_class.new()
    resp.parse(self.send meth)
    cookies = resp.get_cookies
    cookies.should_not be_nil
    cookies.should_not be ''
    cookies.split(';').map(&:strip)
  end


  describe '#get_hidden_inputs' do
    let(:response) do
      res = Rex::Proto::Http::Response.new(200, 'OK')
      res.body = %Q|
      <html>
      <head>
      <body>
      <form action="test.php">
        <input name="input_1" type="hidden" value="some_value_1" />
      </form>
      <form>
        <input name="input_0" type="text" value="Not a hidden input" />
        <input name="input_1" type="hidden" value="some_value_1" />
        <INPUT name="input_2" type="hidden" value="" />
      </form>
      </body>
      </head>
      </htm>
      |
      res
    end

    subject do
      cli = Rex::Proto::Http::Client.new('127.0.0.1')
      cli.connect
      req = cli.request_cgi({'uri'=>'/'})
      res = cli.send_recv(req)
      res
    end

    before(:each) do
      allow_any_instance_of(Rex::Proto::Http::Client).to receive(:request_cgi).with(any_args)
      allow_any_instance_of(Rex::Proto::Http::Client).to receive(:send_recv).with(any_args).and_return(response)
      allow_any_instance_of(Rex::Proto::Http::Client).to receive(:set_config).with(any_args)
      allow_any_instance_of(Rex::Proto::Http::Client).to receive(:close)
      allow_any_instance_of(Rex::Proto::Http::Client).to receive(:connect)
    end

    context 'when an HTML page contains two forms containing hidden inputs' do
      it 'returns an array' do
        expect(subject.get_hidden_inputs).to be_kind_of(Array)
      end

      it 'returns hashes in the array' do
        subject.get_hidden_inputs.each do |form|
          expect(form).to be_kind_of(Hash)
        end
      end

      it 'returns \'some_value_1\' in the input_1 hidden input from the first element' do
        expect(subject.get_hidden_inputs[0]['input_1']).to eq('some_value_1')
      end

      it 'returns two hidden inputs in the second element' do
        expect(subject.get_hidden_inputs[1].length).to eq(2)
      end

      it 'returns an empty string for the input_2 hidden input from the second element' do
        expect(subject.get_hidden_inputs[1]['input_2']).to be_empty
      end
    end
  end


  context "#get_cookies" do

    it 'returns empty string for no Set-Cookies' do
      resp = described_class.new()
      resp.parse(get_cookies_test_no_cookies)
      resp.get_cookies.should eq('')
    end

    it 'returns 5 cookies when given 5 cookies non-sequentially' do
      cookies_array = cookie_sanity_check(:get_cookies_test_five_cookies)
      cookies_array.count.should eq(5)
      cookies_array.should =~ %w(
      pma_lang=en
      pma_collation_connection=utf8_general_ci
      pma_mcrypt_iv=mF1NmTE64IY%3D
      phpMyAdmin=fmilioji5cn4m8bo5vjrrr6q9cada954
      phpMyAdmin=gpjif0gtpqbvfion91ddtrq8p8vgjtue
      )
    end

    it 'returns and parses 5 cookies when given 5 ordered cookies' do
      cookies_array = cookie_sanity_check(:get_cookies_test_five_ordered_cookies)
      cookies_array.count.should eq(5)
      expected_cookies = %w{
      pma_lang=en
      pma_collation_connection=utf8_general_ci
      pma_mcrypt_iv=mF1NmTE64IY%3D
      phpMyAdmin=fmilioji5cn4m8bo5vjrrr6q9cada954
      superC00kie!=stupidcookie
      }
      expected_cookies.shuffle!
      cookies_array.should include(*expected_cookies)
    end

    it 'parses an empty cookie value' do
      cookies_array = cookie_sanity_check(:get_cookies_test_with_empty_cookie)
      cookies_array.count.should eq(5)
      expected_cookies = %w{
      pma_lang=en
      pma_collation_connection=utf8_general_ci
      pma_mcrypt_iv=mF1NmTE64IY%3D
      phpMyAdmin=
      phpMyAdmin=gpjif0gtpqbvfion91ddtrq8p8vgjtue
      }
      expected_cookies.shuffle!
      cookies_array.should include(*expected_cookies)

    end

    it 'parses multiple cookies in one Set-Cookie header' do
      cookies_array = cookie_sanity_check(:get_cookies_test_one_set_cookie_header)
      cookies_array.count.should eq(2)
      expected_cookies = %w{
      wordpressuser_a97c5267613d6de70e821ff82dd1ab94=admin
      wordpresspass_a97c5267613d6de70e821ff82dd1ab94=c3284d0f94606de1fd2af172aba15bf3
      }
      expected_cookies.shuffle!
      cookies_array.should include(*expected_cookies)
    end

    it 'parses comma separated cookies' do
      cookies_array = cookie_sanity_check(:get_cookies_comma_separated)
      cookies_array.count.should eq(3)
      expected_cookies = %w{
      cval=880350187
      session_id_8000=83466b1a1a7a27ce13d35f78155d40ca3a1e7a28
      uid=348637C4-9B10-485A-BFA9-5E892432FCFD
      }
      expected_cookies.shuffle!
      cookies_array.should include(*expected_cookies)
    end

  end

end

