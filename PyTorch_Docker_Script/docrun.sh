docker run --gpus all --name test_dev_yash -it \
--shm-size 32G \
-v /home/yash/github_repositories/Coding_Scripts/PyTorch_Docker_Script:/workspace/test \
-v /home/yash/github_repositories/Coding_Scripts/PyTorch_Docker_Script/Deep-Expander-Networks:/workspace/Deep-Expander-Networks \
-v /home/yash/github_repositories/Coding_Scripts/PyTorch_Docker_Script/cuda-neural-network:/workspace/cuda-neural-network \
-v /home/yash/github_repositories/Coding_Scripts/PyTorch_Docker_Script/DeepLearningCUDA:/workspace/DeepLearningCUDA \
-v /home/yash/github_repositories/Coding_Scripts/PyTorch_Docker_Script/Deep-K-Means-pytorch:/workspace/Deep-K-Means-pytorch \
test_yash bash\n
