class CardsController < DomainableController
  before_action :set_card, only: %i[ show edit publish update destroy ]

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

  # Publish draft
  def publish
    # Try to save updated params with publication time (now)
    if @card.update(card_params.merge(published_at: Time.now.utc))
      # If it saves, enumerate the next number for a given category
      num = Card.where(category_id: @card.category_id).max(:num) + 1
      # Then create a slug for that category and number
      slug = @card.category.slug + '-' + num.to_s

      # Force another validation check of new slug then proceed
      respond_to do |format|
        if @card.update(slug: slug, num: num)
          format.html { redirect_to @card, notice: 'card successfully updated.' }
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
      params.require(:card).permit(:name, :category_id)
    end

end
