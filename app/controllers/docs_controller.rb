class DocsController < AuthorizationController
  # before_action :set_klass

  before_action :set_ticket
  before_action :set_memo
  before_action :set_doc, only: %i[ show edit update destroy ]

  authorize_resource

  def index
    @docs = @memo.docs
  end

  def show
  end

  def new
    @doc = @memo.docs.build
  end

  def edit
  end

  def create
    @doc = @memo.docs.build(doc_params)

    respond_to do |format|
      if @memo.save
        format.html { redirect_to @ticket, notice: 'doc successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @doc.update(doc_params)
        format.html { redirect_to @ticket, notice: 'doc successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doc.destroy

    respond_to do |format|
      format.html { redirect_to @ticket, notice: 'doc successfully destroyed.' }
    end
  end

  private

    # def set_klass
    #   @klass = params[:kind].classify.constantize
    # end

    def set_ticket
      @ticket = Ticket.find_by slug: params[:ticket_id]
    end

    def set_memo
      @memo = @ticket.memos.find params[:id]
    end

    def doc_params
      params.require(:doc).permit!
    end

  end
