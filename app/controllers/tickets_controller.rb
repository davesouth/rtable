class TicketsController < DomainableController
  before_action :set_ticket, only: %i[ show edit publish update destroy ]

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

  # Publish draft
  def publish
    # Try to save updated params with publication time (now)
    if @ticket.update(ticket_params.merge(published_at: Time.now.utc))
      # If it saves, enumerate the next number for a given category
      num = Ticket.where(category_id: @ticket.category_id).max(:num) + 1
      # Then create a slug for that category and number
      slug = @ticket.category.slug + '-' + num.to_s

      # Force another validation check of new slug then proceed
      respond_to do |format|
        if @ticket.update(slug: slug, num: num)
          format.html { redirect_to @ticket, notice: 'ticket successfully updated.' }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
      end
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
