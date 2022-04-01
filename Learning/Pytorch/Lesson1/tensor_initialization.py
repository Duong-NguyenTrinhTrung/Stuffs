import torch

# ======================================================================== #
#                         Initializing Tensor                              #
# ======================================================================== #

device = "cuda" if torch.cuda.is_available() else "cpu"  # Cuda to run on GPU!

# Initializing a Tensor in this case of shape 2x3 (2 rows, 3 columns)
my_tensor = torch.tensor(
    [[1, 2, 3], [4, 5, 6]], dtype=torch.float32, device=device, requires_grad=True
)

# A few tensor attributes
print(
    f"Information about tensor: {my_tensor}"
)  # Prints data of the tensor, device and grad info
print(
    "Type of Tensor {my_tensor.dtype}"
)  # Prints dtype of the tensor (torch.float32, etc)
print(
    f"Device Tensor is on {my_tensor.device}"
)  # Prints cpu/cuda (followed by gpu number)
print(f"Shape of tensor {my_tensor.shape}")  # Prints shape, in this case 2x3
print(f"Requires gradient: {my_tensor.requires_grad}")  # Prints true/fals
