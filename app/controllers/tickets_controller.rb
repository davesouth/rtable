class TicketsController < AuthorizationController
  before_action :set_ticket, only: %i[ show edit update close destroy ]

  authorize_resource

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'ticket successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ticket.memos.build(ticket_params, TicketChange)

    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'ticket successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def close
    @ticket.memos.build({}, TicketClose)

    respond_to do |format|
      if @ticket.update(closed_at: Time.current)
        format.html { redirect_to @ticket, notice: 'ticket successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to :tickets, notice: 'ticket successfully destroyed.' }
    end
  end

  private

    def set_ticket
      @ticket = Ticket.find_by slug: params[:id]
    end

    def ticket_params
      params.require(:ticket).permit(:name, :category_id)
    end

  end
