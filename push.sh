# To be able to use this script, you need to be logged in dockerhub with your creditorwatch credentials.

# get the input from the user
echo "You must log in your dockerhub account to use this script "
echo "Enter the repository name: "
read input


echo "building phpv7"
cd php7 && docker-compose build
docker tag php7-grumphp:latest $input/internal-sast-grumphpv7:latest
docker push $input/internal-sast-grumphpv7:latest
cd ..

echo "building phpv8"
cd php8 && docker-compose build
docker tag php8-grumphp:latest $input/internal-sast-grumphpv8:latest
docker push $input/internal-sast-grumphpv8:latest