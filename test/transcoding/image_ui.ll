; Test that unsignedness of a call to read_imageui is preserved.

; RUN: llvm-as %s -o %t.bc
; RUN: llvm-spirv %t.bc -o %t.spv
; RUN: llvm-spirv -r %t.spv -o %t.rev.bc
; RUN: llvm-dis < %t.rev.bc | FileCheck %s --check-prefix=CHECK-LLVM

; CHECK-LLVM: call spir_func <4 x i32> @_Z12read_imageui14ocl_image1d_ro11ocl_sampleri

; ModuleID = 'foo.ll'
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

%opencl.image1d_ro_t = type opaque
%opencl.sampler_t = type opaque

; Function Attrs: convergent nounwind
define dso_local spir_kernel void @foo(%opencl.image1d_ro_t addrspace(1)* %im, <4 x i32> addrspace(1)* nocapture %res) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !7 !kernel_arg_type_qual !8 {
entry:
  %0 = tail call %opencl.sampler_t addrspace(2)* @__translate_sampler_initializer(i32 19) #2
  %call = tail call spir_func <4 x i32> @_Z12read_imageui14ocl_image1d_ro11ocl_sampleri(%opencl.image1d_ro_t addrspace(1)* %im, %opencl.sampler_t addrspace(2)* %0, i32 42) #3
  store <4 x i32> %call, <4 x i32> addrspace(1)* %res, align 16, !tbaa !9
  ret void
}

declare dso_local %opencl.sampler_t addrspace(2)* @__translate_sampler_initializer(i32) local_unnamed_addr

; Function Attrs: convergent nounwind readonly
declare dso_local spir_func <4 x i32> @_Z12read_imageui14ocl_image1d_ro11ocl_sampleri(%opencl.image1d_ro_t addrspace(1)*, %opencl.sampler_t addrspace(2)*, i32) local_unnamed_addr #1

attributes #0 = { convergent nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="128" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "uniform-work-group-size"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "denorms-are-zero"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { convergent nounwind readonly }

!llvm.module.flags = !{!0}
!opencl.ocl.version = !{!1}
!opencl.spir.version = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, i32 0}
!2 = !{i32 1, i32 2}
!3 = !{!"clang version 8.0.0 (https://git.llvm.org/git/clang.git 2d5099826365b50ff253e48c0832255600e68202) (https://git.llvm.org/git/llvm.git 787527b1af60b0b9d4a35b7fef3fb51cfde43784)"}
!4 = !{i32 1, i32 1}
!5 = !{!"read_only", !"none"}
!6 = !{!"image1d_t", !"uint4*"}
!7 = !{!"image1d_t", !"uint __attribute__((ext_vector_type(4)))*"}
!8 = !{!"", !""}
!9 = !{!10, !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
