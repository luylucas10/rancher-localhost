with the created user logged in, create a group, called tekton pipelines, and set as public, to make easier to use in argo and tekton

in this group, create a public empty project for you first pipeline, I called DotNet (I'll use a dotnet project), but don't worry, we'll create a generic dockerfile pipeline

install helm cli on your machine, and execute 

helm create mypipeline

cd into new directory

configure your repository to this directory 

  161  git init --initial-branch=main
  162  git remote add origin http://gitlab.yourdomain.com/tekton-pipelines/mypipeline.git
  163  git add .
  164  git commit -m "Initial commit"
  165  git push --set-upstream origin main
  166  git -c http.sslVerify=false push --set-upstream origin main


  Now we have a helmchart for this pipeline, lets add in argocd