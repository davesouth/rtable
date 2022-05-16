class TicketsController < AuthorizationController
  before_action :set_ticket, only: %i[ show edit publish update destroy ]

  authorize_resource

  def index
    @tickets = Ticket.published
  end

  def show
  end

  def new
    @ticket = Ticket.find_or_create_draft
  end

  def edit
  end

  # def create
  # end

  def publish
    respond_to do |format|
      @ticket.publish!(ticket_params)
      @ticket.slugify!
      format.html { redirect_to @ticket, notice: 'ticket successfully updated.' }
    rescue => exception
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
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
