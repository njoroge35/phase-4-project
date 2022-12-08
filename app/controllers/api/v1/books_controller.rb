module Api
  module V1
    class BooksController < ApplicationController

      def create
        @book = current_user.books.new(book_params)

        if @book.save
          render json: {
            status: 'SUCCESS',
            message: 'Book created',
            data: @book
          }, status: :ok
        else
          render json: {
            status: 'ERROR',
            message: 'Book creation failed',
            data: @book.errors
          }, status: :unprocessable_entity
        end
      end

      def update
        @book = Book.find(params[:id])

        if @book.update_attributes(book_params)
          render json: {
            status: 'SUCCESS',
            message: 'Book updated',
            data: @book
          }, status: :ok
        else
          render json: {
            status: 'ERROR',
            message: 'Book update failed',
            data: @book.errors
          }, status: :unprocessable_entity
        end
      end

      def index
        @books = current_user.books

        render json: {
          status: 'SUCCESS',
          message: 'Loaded books',
          data: @books
        }, status: :ok
      end

      def show
        @book = Book.find(params[:id])

        render json: {
          status: 'SUCCESS',
          message: 'Loaded book',
          data: @book
        }, status: :ok
      end

      def destroy
        @book = Book.find(params[:id])
        @book.destroy

        render json: {
          status: 'SUCCESS',
          message: 'Deleted book',
          data: @book
        }, status: :ok
      end

      private

        def book_params
          params.permit(:title, :category)
        end
    end
  end
end