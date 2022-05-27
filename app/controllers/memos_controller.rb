class MemosController < AuthorizationController
  before_action :set_klass
  before_action :set_ticket
  before_action :set_memo, only: %i[ show edit update destroy ]

  authorize_resource

  def index
    @memos = @ticket.memos.all
  end

  def show
  end

  def new
    @memo = @ticket.memos.build
  end

  def edit
  end

  def create
    @memo = @ticket.memos.build(memo_params, @klass)

    respond_to do |format|
      if @memo.save
        format.html { redirect_to @ticket, notice: 'memo successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @memo.update(memo_params.merge(published_at: Time.current))
        format.html { redirect_to @ticket, notice: 'memo successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @memo.destroy

    respond_to do |format|
      format.html { redirect_to [@ticket, :memos], notice: 'memo successfully destroyed.' }
    end
  end

  private

    def set_klass
      @klass = params[:kind].classify.constantize
    end

    def set_ticket
      @ticket = Ticket.find_by slug: params[:ticket_id]
    end

    def set_memo
      @memo = @ticket.memos.find params[:id]
    end

    def memo_params
      params.require(params[:kind]).permit(:body)
    end

  end
