class ProvincesController < ApplicationController
  def taxes
    province = Province.find(params[:id])
    render json: {
      gst: province.gst,
      pst: province.pst,
      qst: province.qst,
      hst: province.hst
    }
  end
end
