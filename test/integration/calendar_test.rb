require 'test_helper'

class ShopReservationFrameTest < ActionDispatch::IntegrationTest
  def setup
    @shop = shops(:sample_shop)
  end

  # 予約して、Calendarテーブルの数が増えているか
  # test "create reservation" do
  #   assert_difference 'Calendar.count', 1 do
  #     get c_new_path(@shop)
  #     post c_confirm_path(@shop), params: { calendar: { rent_date: "2021-04-05, 12:00:00"} }
  #     follow_redirect!
  #     post c_create_path(@shop), params: { calendar: { candidate_days: @reservation_days} }
  #   end
  # end

  # 複数日予約して、Calendarテーブルの数が増えているか
  # 過去日付を選択した際にエラーとして戻されるか
  # すでに予約が入っている日時を選択して、エラーとして戻されるか
  # オーナーが予約開放していない日時を選択してエラーとして戻されるか
  # 3ヶ月以上先の予約をした場合にエラーで戻される

end