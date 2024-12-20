require "test_helper"

class GoalsControllerTest < ActionDispatch::IntegrationTest
 # spec/controllers/goals_controller_spec.rb
require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  # Définir un objectif à utiliser dans les tests
  let(:goal) { create(:goal) }

  # Test de l'action 'index' (afficher tous les objectifs)
  describe "GET #index" do
    it "returns a successful response" do
      # Faire une requête GET à l'action 'index'
      get :index
      # Vérifier que la réponse est réussie (status 200)
      expect(response).to have_http_status(:success)
      # Vérifier que tous les objectifs sont assignés à la variable d'instance @goals
      expect(assigns(:goals)).to eq(Goal.all)
    end
  end

  # Test de l'action 'show' (afficher un objectif spécifique)
  describe "GET #show" do
    it "returns a successful response for an existing goal" do
      # Faire une requête GET à l'action 'show' avec l'ID d'un objectif existant
      get :show, params: { id: goal.id }
      # Vérifier que la réponse est réussie (status 200)
      expect(response).to have_http_status(:success)
      # Vérifier que l'objectif assigné est celui que nous avons créé au début
      expect(assigns(:goal)).to eq(goal)
    end

    it "returns a 404 response for a non-existent goal" do
      # Faire une requête GET à l'action 'show' avec un ID inexistant
      get :show, params: { id: 999999 }
      # Vérifier que la réponse est un 404 (objectif introuvable)
      expect(response).to have_http_status(:not_found)
    end
  end

  # Test de l'action 'new' (formulaire pour créer un nouvel objectif)
  describe "GET #new" do
    it "returns a successful response" do
      # Faire une requête GET à l'action 'new'
      get :new
      # Vérifier que la réponse est réussie (status 200)
      expect(response).to have_http_status(:success)
    end
  end

  # Test de l'action 'create' (créer un nouvel objectif)
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new goal and redirects to the goal's page" do
        # Vérifier qu'un nouvel objectif est créé et que l'utilisateur est redirigé vers la page de cet objectif
        expect {
          post :create, params: { goal: { title: "New Goal" } }
        }.to change(Goal, :count).by(1)
        # Vérifier que la redirection a eu lieu vers la page de l'objectif créé
        expect(response).to redirect_to(goal_path(Goal.last))
      end
    end

    context "with invalid attributes" do
      it "does not create a new goal and re-renders the new template" do
        # Vérifier qu'aucun objectif n'est créé quand l'attribut 'title' est invalide (nil)
        expect {
          post :create, params: { goal: { title: nil } }
        }.to_not change(Goal, :count)
        # Vérifier que le formulaire de création est réaffiché en cas d'erreur (statut 422)
        expect(response).to render_template(:new)
      end
    end
  end

  # Test de l'action 'update' (mettre à jour un objectif existant)
  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the goal and redirects to the goal's page" do
        # Faire une requête PATCH pour mettre à jour l'objectif avec un titre valide
        patch :update, params: { id: goal.id, goal: { title: "Updated Goal" } }
        # Recharger l'objectif pour vérifier qu'il a bien été mis à jour
        goal.reload
        # Vérifier que le titre de l'objectif a été mis à jour
        expect(goal.title).to eq("Updated Goal")
        # Vérifier que la redirection a eu lieu vers la page de l'objectif mis à jour
        expect(response).to redirect_to(goal_path(goal))
      end
    end

    context "with invalid attributes" do
      it "does not update the goal and re-renders the edit template" do
        # Faire une requête PATCH avec un titre invalide (nil)
        patch :update, params: { id: goal.id, goal: { title: nil } }
        # Vérifier que l'objectif n'a pas été mis à jour
        expect(goal.reload.title).not_to eq(nil)
        # Vérifier que le formulaire d'édition est réaffiché en cas d'erreur
        expect(response).to render_template(:edit)
      end
    end
  end

  # Test de l'action 'destroy' (supprimer un objectif)
  describe "DELETE #destroy" do
    it "deletes the goal and redirects to the goals index page" do
      # Créer un objectif à supprimer
      goal_to_destroy = create(:goal)
      # Vérifier qu'un objectif est supprimé et que l'utilisateur est redirigé vers la page d'index
      expect {
        delete :destroy, params: { id: goal_to_destroy.id }
      }.to change(Goal, :count).by(-1)
      # Vérifier que la redirection a eu lieu vers la page d'index des objectifs
      expect(response).to redirect_to(goals_path)
    end
  end
end

end
