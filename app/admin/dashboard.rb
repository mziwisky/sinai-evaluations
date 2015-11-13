ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => "Dashboard"

  content :title => "Dashboard" do
    panel "README" do
      para <<-PARA
First thing you need to do is add the providers that students will be able to select from.  All you need is name and email of each provider.  Click "Providers" along the top bar and use the "Add Provider" button.
      PARA
      para <<-PARA
Please do not delete any providers.  If you no longer want one to be selectable by students (cuz they got fired or something), then click "Edit" and check the "Disabled" box and "Update Provider".  Eventually I'll make it so disabled providers are hidden by default so they don't clutter up your interface.  I'll also make it so you _can't_ delete them, just to be safe.
      PARA
      para <<-PARA
After providers are added, you can click "Evaluations" at the top and "New Evaluation".  Enter the student's name and email and click "Create Evaluation", and they will be emailed w/ a link that lets them fill out the basic info (student type, hospital, and choose a provider).  Once they've submitted that, the provider they chose will be emailed automatically w/ a link to fill out their evaluation.  You can see the status of the evaluations on that admin interface (i.e. whether the student did their part yet and whether the provider did), but i don't have a nice view of the results yet.  The evaluations are saved tho, i just have to format them nicely for you.
      PARA
      para <<-PARA
If any questions or issues come up, you have my email address.
      PARA
      para <<-PARA
--Mike
      PARA
    end

    panel "Previews" do
      para "Here you can preview what the forms look like"
      ul do
        li link_to('Student form', student_evaluation_path('demo'))
        li link_to('Evaluator form', provider_evaluation_path('demo'))
      end
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
