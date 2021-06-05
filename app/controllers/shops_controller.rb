class ShopsController < ApplicationController
  before_action :set_shop, except: [:new, :create, :index, :zip, :select_prefecture]
  before_action :set_owner, only: [:create, :show]
  before_action :before_login_owner, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_owner, only: [:edit, :update, :destroy]

  include UserSessionsHelper
  
  def index
    @shops = Shop.all.includes(:tags).page(params[:page]).per(50)
    @tags = Tag.all
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = @owner.shops.build(shop_params) 
    if params[:shop][:start_time] != "" && params[:shop][:end_time] != ""
    set_business_time   
    end
    unless params[:shop][:image]
      @shop.image = "shop_noimage.jpg"
    end
      # @shopを保存できたら、tag_to_shopテーブルにタグも保存
    if @shop.save && params[:shop][:tags]
      params[:shop][:tags].each do |tag|
        shop_tag = TagToShop.new(shop_id: @shop.id, tag_id: tag)
        shop_tag.save
      end
      flash[:success] = "店舗登録されました"
      redirect_to s_show_path(@shop)
    elsif @shop.save
      flash[:success] = "店舗登録されました"
      redirect_to s_show_path(@shop)
    else
      render 'new'
    end
  end

  def show
    @owner = @shop.owner
    @tags = @shop.tags
  end

  def edit
  end

  def update
    set_business_time
    if @shop.update(shop_params) && params[:shop][:tags]
      params[:shop][:tags].each do |tag|
        shop_tag = TagToShop.new(shop_id: @shop.id, tag_id: tag)
        shop_tag.save
      end
      flash[:success] = "店舗情報は更新されました"
      redirect_to s_show_path(@shop)
    elsif @shop.update(shop_params)
      flash[:success] = "店舗情報は更新されました"
      redirect_to s_show_path(@shop)
    else
      render 'edit'
    end
    
  end

  def destroy
    @shop.del_flg = 1
    @shop.save
    flash[:success] = "店舗は削除されました"
    redirect_to root_path
  end

  def zip
  end

  def select_prefecture
    if params[:tags] 
      @shops = Shop.where("prefecture LIKE ?", "%#{params[:prefecture]}%").joins(:tag_to_shops).where(tag_to_shops: {tag_id: params[:tags]})
    else
      @shops = Shop.where("prefecture LIKE ?", "%#{params[:prefecture]}%")
    end
  end

  def create_business_time
  end

  # オーナーが予約開放する際に見るカレンダー表示
  def reservation_frame
    set_available_days
    @today = Date.today
    call_business_time
    set_calendar
  end

  # オーナーが予約開放した日時をAvailableテーブルに格納
  def set_reservation_frame
    start_time = params[:start_time].to_i
    end_time = params[:end_time].to_i
    while start_time < end_time do
        if start_time < 10
          @shop.availables.create(rent_date: params[:rent_date], start_time: "0#{start_time}:00:00")
        else
          @shop.availables.create(rent_date: params[:rent_date], start_time: "#{start_time}:00:00")
        end
      start_time += 1
    end
    respond_to do |format|
      set_available_days
      session.delete(:day)
      @today = Date.today
      call_business_time
      set_calendar
      format.html { redirect_to s_res_path(params[:id]) }
      format.js { @status = "success"}
    end
  end

  def remove_reservation_frame
    @available_days = session[:day]
    if @available_days == nil
      flash[:warning] = "開放している日時がありません"
      redirect_to s_res_path(params[:id])
    end
    end_time = params[:end_time].to_i
    start_time = params[:start_time].to_i
    while start_time < end_time do
      if start_time < 10
        # @available_days.delete("#{params[:rent_date]}, 0#{start_time}:00:00")
        available = Available.find_by(shop_id: @shop.id, rent_date: params[:rent_date], start_time: "0#{start_time}:00:00")
        available.destroy
      else
        # @available_days.delete("#{params[:rent_date]}, #{start_time}:00:00")
        available = Available.find_by(shop_id: @shop.id, rent_date: params[:rent_date], start_time: "#{start_time}:00:00")
        available.destroy
      end
      start_time += 1
    end
    respond_to do |format|
    set_available_days
    session.delete(:day)
    @today = Date.today
    call_business_time
    set_calendar
    format.html { redirect_to s_res_path(params[:id]) }
    format.js
    end
  end

  def set_reservation_day_frame
    # @available_days = session[:day]
    # available_days?
    end_time = params[:end_time].to_i
    start_time = params[:start_time].to_i
    start_date = params[:rent_start].to_date
    end_date = params[:rent_end].to_date
    while start_date <= end_date do
      if params[:day].include?("#{start_date.wday}")
        while start_time < end_time do
          if start_time < 10
            # @available_days.push("#{start_date.strftime("%Y-%m-%d")}, 0#{start_time}:00:00")
            @shop.availables.create(rent_date: start_date.strftime("%Y-%m-%d"), start_time: "0#{start_time}:00:00")
          else
            # @available_days.push("#{start_date.strftime("%Y-%m-%d")}, #{start_time}:00:00")
            @shop.availables.create(rent_date: start_date.strftime("%Y-%m-%d"), start_time: "#{start_time}:00:00")
          end
          start_time += 1
        end
      end
    start_date += 1
    start_time = params[:start_time].to_i
    end

    respond_to do |format|
      set_available_days
      session.delete(:day)
      @today = Date.today
      call_business_time
      set_calendar
      format.html { redirect_to s_res_path(params[:id]) }
      format.js { @status = "success"}
    end
  end

  def modal_register
  end

  def next
    today = params[:today].to_date
    @today = today + 7
    @available_days = session[:day]
    call_business_time
    set_calendar
    render 'reservation_frame'
  end

  def prev
    today = params[:today].to_date
    @today = today - 7
    @available_days = session[:day]
    call_business_time
    set_calendar
    render 'reservation_frame'
  end

  private

    def shop_params
      # tag_to_shops_attributes必要ない？
      params.require(:shop).permit(:name, :prefecture, :city, :address, :tel, :station, :capacity, :image, :price, :content, :zip_code, :start_time, :end_time, :tags, tag_to_shops_attributes: [:id, :tag_id, :shop_id])
    end

    def set_shop
      @shop = Shop.find_by(id: params[:id])
    end

    def set_owner
      @owner = Owner.find_by(id: session[:owner_id])
    end

    def correct_owner
      set_shop
      set_owner
      if current_user.admin == 1
        true
      elsif @shop.owner != @owner
        flash[:danger] = "オーナー権限がありません"
        redirect_to root_path
      end
    end

    # 店側がカレンダーに表示させる時間帯を登録する場合の処理
    def set_business_time
      if params[:shop][:start_time] != "" && params[:shop][:end_time] != ""
        s_time = params[:shop][:start_time].to_i
        e_time = params[:shop][:end_time].to_i
        business_time = []  
        while s_time < e_time do
          business_time.push(s_time)
          s_time = s_time + 1
        end    
        @shop.business_time = business_time
      end
    end

    # カレンダーに表示する時間帯を呼び出す
    def call_business_time
      # if @shop.business_time 
      #   able_time = @shop.business_time
      #   slim_time = able_time.split(",")
      #   slim_time[0] = slim_time.first.delete("[")
      #   slim_time[-1] = slim_time.last.delete("]")
      #   @able_time = slim_time
      # else
        @able_time = (1..24).to_a
      # end
    end

    # カレンダーを本日日付から始めるための処理
    def set_calendar
      @year = @today.year
      @year_month = "#{@today.year} / #{@today.month}"
        @week = []
      7.times do |i|
        w = @today + i
        @week.push(w)
      end
      # すでに入っている予約の日時を@rentDaysとして取得
      rent_dayTimes = Available.where(shop_id: params[:id]).pluck(:rent_date, :start_time)
      @t = []
      @rentDays = []
      rent_dayTimes.each do |dayTime|
        s_rent = "#{dayTime[0]}, #{dayTime[1]}"
        @rentDays.push(s_rent)
      end
      # @tに１週間分の日付と曜日いれる
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

    # オーナーが開放した日時を取得
    def set_available_days
      @available_days = []
      a_days = Available.where(shop_id: @shop.id)
      a_days.each do |day|
        @available_days.push("#{day.rent_date}, #{day.start_time}")
      end
    end
end