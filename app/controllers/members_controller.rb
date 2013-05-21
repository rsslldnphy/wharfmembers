class MembersController < ApplicationController

  skip_before_filter :authenticate_user!, only: :register

  def index
    @members = Member.search(params[:search]).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv   { send_data Member.all.to_csv }
      format.text  { render text: Member.all.to_txt }
    end
  end

  def show
    @member = Member.find_by(no: params[:id])
  end

  def current
    @members = Member.current.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv   { send_data Member.current.to_csv }
      format.text  { render text: Member.current.to_txt }
    end
  end

  def pending
    @members = Member.pending.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv   { send_data Member.pending.to_csv }
      format.text  { render text: Member.pending.to_txt }
    end
  end

  def mailing_list
    @members = Member.mailing_list.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv   { send_data Member.mailing_list.to_csv }
      format.text  { render text: Member.mailing_list.to_txt }
    end
  end

  def expired
    @members = Member.expired.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv   { send_data Member.expired.to_csv }
      format.text  { render text: Member.expired.to_txt }
    end
  end

  def new
    @member = Member.new
  end

  def register
    @member = Member.new
    render layout: false
  end

  def edit
    @member = Member.find_by(no: params[:id])
  end

  def renew
    @member = Member.find_by(no: params[:id])
    @member.renew
    redirect_to @member
  end

  def bulk_action
    if params.fetch(:ids, []).any?
      @members = Member.find(params[:ids])
      if params['delete-selected'].present?
        @members.each(&:destroy)
      elsif params['complete-selected'].present?
        @members.each(&:complete).each(&:save)
      elsif params['renew-selected'].present?
        @members.each(&:renew)
      end
    end
    redirect_to :back
  end

  def create
    @member = Member.new(params[:member])
    if @member.save
      if params[:register]
        render text: "Thanks for registering, #{@member.full_name}"
      else
        redirect_to @member, notice: 'Member was successfully created.'
      end
    else
      if params[:register]
        render action: "register", layout: false
      else
        render action: "new"
      end
    end
  end

  def update
    @member = Member.find_by(no: params[:id])
    if @member.update_attributes(params[:member])
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @member = Member.find_by(no: params[:id])
    @member.destroy
    redirect_to members_url
  end
end
