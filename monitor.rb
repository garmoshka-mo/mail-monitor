require 'json'
require 'mail'
require 'byebug'
require 'active_support/time'

def check
  curl = "curl 'https://n53489.yclients.com/api/v1/book_dates/25496?service_ids%5B%5D=855861&staff_id=17608&date=2018-05-01' -H 'cookie: auth=24e1e939beccbd7f5030f105cdea766d; lang=1; yc_vid=67387237192; yc_firstvisit=1524391936; _ym_uid=152439194582474034; _ym_isad=1; _ym_visorc_35239280=w' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: ru-RU' -H 'authorization: Bearer yusw3yeu6hrr4r9j3gw6, User d14b230d1c130d56fd158acca39fc0f4' -H 'accept: application/json, text/plain, */*' -H 'referer: https://n53489.yclients.com/company:25496/idx:0/date?lang=&o=m17608s855861' -H 'authority: n53489.yclients.com' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36' --compressed"
  result = `#{curl}`
  json = JSON.parse result

  if json['booking_days'].has_key? '4'
    send_mail "April: #{json['booking_days']['4']}"
    sleep 2.hours
  end

  if json['booking_days']['5'].include? 5
    send_mail '5 May'
    sleep 2.hours
  end
end

def send_mail(body)
  puts body
  Mail.deliver do
    from     'info@dan@coav.ru'
    to       'dan@coav.ru'
    subject  'TommyGun has!'
    body     body
  end
end

while true
  check
  sleep 30.seconds
end