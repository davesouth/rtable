class TicketsController < DomainableController
  before_action :set_ticket, only: %i[ show edit update destroy ]

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
        format.html { redirect_to @ticket, notice: 'Ticket successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to [@account, @ticket], notice: 'Ticket successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to :tickets, notice: 'Ticket successfully destroyed.' }
    end
  end

  private

    def set_ticket
      @ticket = Ticket.find_by slug: params[:id]
    end

    def ticket_params
      params.require(:ticket).permit(:name, :slug, :kind)
    end

  end
