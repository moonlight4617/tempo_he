module OwnerSessionsHelper
  def remember_owner(owner)
    owner.save_owner_remember_digest
    cookies.permanent.signed[:owner_id] = owner.id
    cookies.permanent[:remember_owner_token] = owner.remember_token
  end

  def current_owner
    if (owner_id = session[:owner_id])
      @owner ||= Owner.find_by(id: owner_id)
    elsif (owner_id = cookies.signed[:owner_id])
      owner = Owner.find_by(id: owner_id)
      if owner && owner.authenticated?(cookies[:remember_owner_token])
        session[:owner_id] = owner.id
        @owner = owner
      end
    end
  end

  def logged_in_owner?
    session[:owner_id] != nil
  end

  def forget_owner(owner)
    owner.forget_owner_remember_digest
    cookies.delete(:owner_id)
    cookies.delete(:remember_owner_token)
  end

  def log_out_owner
    forget_owner(@owner)
    session.delete(:owner_id)
    @owner = nil
  end
end