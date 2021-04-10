require 'test_helper'

class ShopReservationFrameTest < ActionDispatch::IntegrationTest
  def setup
    @shop = shops(:sample_shop)
  end

  def set_day
    @day = Date.today.wday
    @day1 = Date.today.wday+1
  end

  # 予約開放し、Availableテーブルのデータが増えているか
  test "open reservation frame" do
    get s_res_path(@shop)
    assert_difference 'Available.count', 1 do
      post s_set_res_path(@shop), params: { rent_date: Date.today, start_time: "10", end_time: "11"}
    end
  end

  # 曜日開放し、Availableテーブルのデータが増えているか
  test "open reservation day frame" do
    get s_res_path(@shop)
    assert_difference 'Available.count', 4 do
      post s_day_res_path(@shop), params: { rent_start: Date.today, rent_end: Date.today+13, start_time: "10", end_time: "11", day: ["0", "1"]}
    end
  end

  # 曜日開放した際に、すでに予約開放している日時は弾きつつも、他日時は開放されているか
  # test "open reservation frame except duplicate" do
  #   get s_res_path(@shop)
  #   post s_set_res_path(@shop), params: { rent_date: Date.today, start_time: "10", end_time: "11"}
  #   assert_difference 'Available.count', 3 do
  #     post s_day_res_path(@shop), params: { rent_start: Date.today, rent_end: Date.today+13, start_time: "10", end_time: "11", day: ["#{@day}", "#{@day1}"]}
  #   end
  # end

  # 予約閉鎖し、Availableテーブルのデータが減っているか
  test "close reservation frame" do
    assert_no_difference 'Available.count' do
      get s_res_path(@shop)
      post s_set_res_path(@shop), params: { rent_date: Date.today, start_time: "10", end_time: "11"}
      follow_redirect!
      delete s_remove_res_path(@shop), params: { rent_date: Date.today, start_time: "10", end_time: "11"}
    end
  end
end