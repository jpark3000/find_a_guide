class SpecialtiesController < ApplicationController
  def create
    current_user.specialties.destroy_all
    new_specialties = params['specialty'].keys
    new_specialties.each{|specialty_id| UsersSpecialty.create(user_id: current_user.id, specialty_id: specialty_id)}
    format.json{ render :json => {response: 'Specialties Updated'}}
  end
end