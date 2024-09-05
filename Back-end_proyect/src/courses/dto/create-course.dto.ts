import { ApiProperty } from '@nestjs/swagger';
import {
  IsNumber,
  IsOptional,
  IsString,
  IsUUID,
  MinLength,
} from 'class-validator';

export class CreateCourseDto {
  @ApiProperty({
    description: 'Nombre del curso',
    nullable: false,
    example: 'Matemáticas',
    minLength: 3,
  })
  @IsString()
  @MinLength(3)
  nombre: string;

  @ApiProperty({
    description: 'Descripción del curso',
    nullable: false,
    example: 'Curso de matemáticas básicas',
    minLength: 10,
  })
  @IsString()
  @MinLength(10)
  descripcion: string;

  @ApiProperty({
    description: 'Código de acceso al curso',
    nullable: false,
    example: 'MATG101',
    minLength: 6,
  })
  @IsString()
  @MinLength(6)
  codigo_acceso: string;

  @ApiProperty({
    description: 'Tiempo en minutos para responder cada pregunta',
    nullable: true,
    example: 30,
  })
  @IsNumber()
  @IsOptional()
  temporizador?: number;
}
