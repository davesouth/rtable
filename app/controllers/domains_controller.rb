class DomainsController < AdminController
  before_action :set_domain, only: %i[ show edit update destroy ]

  def index
    @domains = Domain.all
  end

  def show
  end

  def new
    @domain = Domain.new
  end

  def edit
  end

  def create
    @domain = Domain.new(domain_params)

    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: 'domain successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: 'domain successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to :domains, notice: 'domain successfully destroyed.' }
    end
  end

  private
    def set_domain
      @domain = Domain.find_by(slug: params[:id])
    end

    def domain_params
      params.require(:domain).permit(:name, :slug)
    end
end
