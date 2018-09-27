class Api::V1::CampaignsController < ApplicationController
  before_action :load_campaign, only: %i(show)
  before_action :campaign_owner, only: %i(update destroy)
  before_action :authorize_request, only: %i(create update destroy) 

  def show 
    render json: {
      status: true,
      data: @campaign.as_json(only: [:id, :public_key])
    }
  end
  
  def create
    @campaign = @current_user.campaigns.new campaign_params
    if @campaign.save
      render json: {
        status: true,
        data: @campaign.as_json(only: [:id, :public_key])
      }
    else
      render json: {
        status: false,
        message: @campaign.errors.full_message
      }
    end
  end

  def update
    if @campaign.update_attributes load_campaign
      render json: {
        status: true
      }
    else
      render json: {
        status: false,
        message: @campaign.errors.full_message
      }
    end
  end

  def destroy
    if @campaign.destroy
      render json: {
        status: true
      }
    else
      render json: {
        status: false,
        message: @campaign.errors.full_message
      }
    end
  end

  def index
    @campaigns = Campaign.all
    render json: {
      data: @campaigns.as_json(only: [:id, :public_key])
    } 
  end

  private
  def load_campaign
    @campaign = Campaign.find_by id: params[:id]
    unless @campaign
      render json: {
        status: false,
        message: Settings.not_found
      }
    end
  end

  def campaign_params
    params.require(:campaign).permit :public_key
  end

  def campaign_owner
    @campaign = @current_user.campaigns.find_by id: params[:id]
    unless @campaign
      render json: {
        status: false,
        message: Settings.not_found
      }
    end
  end
end