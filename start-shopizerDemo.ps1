docker run -d --name=api.shopizer --network "build-pipeline" shopizerecomm/shopizer:latest
docker run -d --name=admin.shopizer --network "build-pipeline" -e "APP_BASE_URL=http://api.shopizer:8080/api" shopizerecomm/shopizer-admin
docker run -d --name=shopizer --network "build-pipeline" -e "APP_MERCHANT=DEFAULT" -e "APP_BASE_URL=http://api.shopizer:8080" shopizerecomm/shopizer-shop-reactjs