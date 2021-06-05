class CalendarsController < ApplicationController

before_action :set_shop, except: :index_for_user

  # ユーザーに対して、今している予約一覧の表示
  def index_for_user
    @calendars = Calendar.where(user_id: session[:user_id])
  end

  # ユーザーが予約する際の表示
  def new
    @calendars = @shop.calendars.where(shop_id: params[:id])
    @today = Date.today
    @year = @today.year
    @year_month = "#{@today.year} / #{@today.month}"
    set_business_time
    set_calendar    
  end

  def create
    reserve_days = params[:calendar][:candidate_days]
    reserve = reserve_days.split
    i = 0
    while i < reserve.length do
      @shop.calendars.create(
        rent_date: reserve[i],
        start_time: reserve[i+1],            
        user_id: session[:user_id]
      )
      @available = @shop.availables.find_by(
        rent_date: reserve[i],
        start_time: reserve[i+1]
      )
      @available.delete
      i += 2
    end
    redirect_to c_index_path
  end

  # ユーザーへの確認画面
  def confirm
    # 「次の週へ」
    if params[:next] != nil
      today = params[:calendar][:day].to_date
      @today = today + 7
      set_business_time
      set_calendar
      render "new"

    # 「前の週へ」
    elsif params[:prev] != nil
      today = params[:calendar][:day].to_date
      @today = today - 7
      set_business_time
      set_calendar
      render "new"

    # 日時選択した場合
    elsif params[:calendar][:rent_date] != nil
      @candidate_days = params[:calendar][:rent_date]

      # 予約可能日を@availableに格納
      available = Available.where(shop_id: @shop.id).pluck(:rent_date, :start_time)
      @available = []
      i = 0
      while i < available.length do
        r = "#{available[i][0]}, #{available[i][1]}"
        @available.push(r)
        i += 1
      end

      # ユーザーが選択した日時が過去日付でないか、選択可能日時かどうかをチェック
      i = 0
      while i < @candidate_days.length do
        r_date = @candidate_days[i].to_date
        dt = @candidate_days[i].split
        r_datetime = "#{r_date}, #{dt[1]}"
        if r_date < Date.today
          flash[:danger] = "過去日付は選択できません"
          redirect_to c_new_path
        elsif !@available.include?(r_datetime)
          flash[:danger] = "予約可能日時以外は選択できません"
          redirect_to c_new_path
        end
        i += 1
      end
    else
      flash[:danger] = "日時を選択してください"
      redirect_to c_new_path
    end
  end

  # ユーザーに対して、今入っている予約一覧の表示
  def s_index
    @calendars = @shop.calendars.where(user_id: session[:user_id]).where(rent_date: Date.today..Float::INFINITY)
  end

  private

    def set_shop
      @shop = Shop.find(params[:id])
    end

    # 予約できる時間の設定。店舗が時間設定していればその通りの時間を。設定していなければデフォルトで9-23時を登録
    def set_business_time
      # if @shop.business_time.present?
      #   able_time = @shop.business_time
      #   slim_time = able_time.split(",")
      #   slim_time[0] = slim_time.first.delete("[")
      #   slim_time[-1] = slim_time.last.delete("]")
      #   @able_time = slim_time
      # else
        @able_time = (0..23).to_a
      # end
    end

    def set_calendar
      @year = @today.year
      @year_month = "#{@today.year} / #{@today.month}"
        @week = []
      7.times do |i|
        w = @today + i
        @week.push(w)
      end
      # 店舗が開放している日付を@availableに格納
      available = Available.where(shop_id: @shop.id).pluck(:rent_date, :start_time)
      @available = []
      i = 0
      while i < available.length do
        r = "#{available[i][0]}, #{available[i][1]}"
        @available.push(r)
        i += 1
      end
      # @tに１週間分の日付と曜日いれる
      @t = []
      @able_time.each do |t|
        @week.each do |w|
          dt = Time.zone.local(@year, w.month, w.mday, t)
          calendar_date = dt.to_s
          c_date = calendar_date.split
          c_dateTime = c_date[0] + ", " + c_date[1]
          @t.push(c_dateTime)
        end
      end
    end    
end
