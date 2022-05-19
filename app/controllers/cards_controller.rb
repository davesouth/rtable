class CardsController < AuthorizationController
  before_action :set_card, only: %i[ show edit update destroy ]

  authorize_resource

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to [:edit, @card], notice: 'card successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

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
      params.require(:card).permit(:name, :category_id, :email)
    end

end
