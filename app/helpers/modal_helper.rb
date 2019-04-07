module ModalHelper
  def modal(title:, &block)
    @modal_title = title
    content_for(:modal, &block)
  end
end