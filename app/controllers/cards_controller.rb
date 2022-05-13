class CardsController < DomainableController
  before_action :set_card, only: %i[ show edit update destroy ]

  def index
    @cards = Card.published
  end

  def show
  end

  def new
    @card = Card.find_or_create_draft
  end

  def edit
  end

  # Unused
  # def create
  # end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'card successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to :cards, notice: 'card successfully destroyed.' }
    end
  end

  private

    def set_card
      @card = Card.find_by slug: params[:id]
    end

    def card_params
      params.require(:card).permit(:name)
    end

end
