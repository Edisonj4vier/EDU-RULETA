import { IsString, IsUUID, MinLength } from 'class-validator';

export class CreateCourseDto {
  @IsString()
  @MinLength(3)
  nombre: string;

  @IsString()
  @MinLength(10)
  descripcion: string;

  @IsString()
  @MinLength(6)
  codigo_acceso: string;

  @IsUUID()
  user_id: string;
}
