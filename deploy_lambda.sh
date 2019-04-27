# Copy, patch and deploy source code with specific dependencies to Lambda
# AWS account is 675801850295
# Make sure patch.zip with dependencies are on remote end host

echo 'Copying source file to end host'
scp -i "~/Desktop/test.pem" /Users/yongco/Documents/YongcoHydraTestPackage/src/YongcoHydraTestPackage/reporter_lambda.py ec2-user@ec2-54-245-61-33.us-west-2.compute.amazonaws.com:/home/ec2-user

ssh -i "~/Desktop/test.pem" ec2-user@ec2-54-245-61-33.us-west-2.compute.amazonaws.com << EOF
    echo 'Patching source file with dependencies'
    zip -r9 /home/ec2-user/patch.zip reporter_lambda.py 
    echo 'Deploying to Hydra-reporter-test'
    aws lambda update-function-code --function-name Hydra-reporter-test --zip-file fileb://patch.zip --region us-west-2
EOF