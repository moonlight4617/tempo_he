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
    available = Available.where(shop_id: @shop.id).pluck(:rent_date, :start_time)
    @available = []
      i = 0
      while i < available.length do
        r = "#{available[i][0]}, #{available[i][1]}"
        @available.push(r)
        i += 1
      end
    set_business_time
    set_calendar    
  end

  def create
    reserve_days = params[:calendar][:candidate_days]
    reserve = reserve_days.split
    i = 0
    while i <= reserve.length do
      @shop.calendars.create(
        rent_date: reserve[i],
        start_time: reserve[i+1],            
        user_id: session[:user_id]
        )
        i += 2
    end
    redirect_to c_index_path
  end

  # def create
  #   if params[:next] != nil
  #     today = params[:calendar][:day].to_date
  #     @today = today + 7
  #     set_business_time
  #     set_calendar
  #     render "new"
  #   elsif params[:prev] != nil
  #     today = params[:calendar][:day].to_date
  #     @today = today - 7
  #     set_business_time
  #     set_calendar
  #     render "new"
  #   elsif params[:calendar][:rent_date] != nil
  #     params[:calendar][:rent_date].each do |reserve|
  #       res = reserve.split
  #       @calendar = @shop.calendars.create(
  #             rent_date: res[0],
  #             start_time: res[1],            
  #             user_id: session[:user_id]
  #           )
  #     end
  #     redirect_to c_index_path
  #   else
  #     flash[:danger] = "日時をチェックしてください"
  #     redirect_to c_new_path
  #   end
  # end

  def confirm
    if params[:calendar][:rent_date] != nil
      @candidate_days = params[:calendar][:rent_date]
      available = Available.where(shop_id: @shop.id).pluck(:rent_date, :start_time)
      @available = []
      i = 0
      while i < available.length do
        r = "#{available[i][0]}, #{available[i][1]}"
        @available.push(r)
        i += 1
      end
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
      # @candidate_days
    else
      flash[:danger] = "日時を選択してください"
      redirect_to c_new_path
    end
 
  end

  # オーナーに対して、今入っている予約一覧の表示
  def s_index
    @calendars = @shop.calendars.where(user_id: session[:user_id])
  end

  private

    def set_shop
      @shop = Shop.find(params[:id])
    end

    # 予約できる時間の設定。店舗が時間設定していればその通りの時間を。設定していなければデフォルトで9-23時を登録
    def set_business_time
      if @shop.business_time 
        able_time = @shop.business_time
        slim_time = able_time.split(",")
        slim_time[0] = slim_time.first.delete("[")
        slim_time[-1] = slim_time.last.delete("]")
        @able_time = slim_time
      else
        @able_time = (9..23).to_a
      end
    end

    def set_calendar
      @year = @today.year
      @year_month = "#{@today.year} / #{@today.month}"
        @week = []
      7.times do |i|
        w = @today + i
        @week.push(w)
      end

      # すでに入っている予約の日時を@rentDaysとして取得
      rentDays = Calendar.where(shop_id: params[:id]).pluck(:rent_date, :start_time)
      @rentDays = []
      i = 0
      while i < rentDays.length do
        r = "#{rentDays[i][0]}, #{rentDays[i][1]}"
        @rentDays.push(r)
        i += 1
      end
      # rent_dayTimes.each do |dayTime|
      #   s_rent = "#{dayTime[0]}, #{dayTime[1]}"
      #   @rentDays.push(s_rent)
      # end
      # rentDays ? @rentDays = rentDays : @rentDays = []
      
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
