class CardsController < AuthorizationController
  before_action :set_card, only: %i[ show edit publish update destroy ]

  authorize_resource

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

  def publish
    respond_to do |format|
      @card.publish!(card_params)
      @card.slugify!
      format.html { redirect_to @card, notice: 'card successfully updated.' }
    rescue => exception
      format.html { render :new, status: :unprocessable_entity }
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
